$(document).ready(function () {
    // Cache DOM elements
    const chatButton = $('#chat-button');
    const chatContainer = $('#chat-container');
    const closeChat = $('#close-chat');
    const sendButton = $('#send-button');
    const userInput = $('#user-input');
    const chatMessages = $('#chat-messages');

    // State variables
    let welcomeMessageShown = false;
    let isTyping = false;
    const typingDelay = 500;
    let typingTimer;

    // Add event listeners
    chatButton.on('click', toggleChat);
    closeChat.on('click', closeChathanlde);
    sendButton.on('click', sendMessage);
    userInput.on('keypress', handleKeyPress);
    userInput.on('input', handleTyping);
    $(document).on('click', handleClickOutside);

    function toggleChat() {
        chatContainer.toggleClass('hidden');
        if (!chatContainer.hasClass('hidden')) {
            userInput.focus();
            if (!welcomeMessageShown) {
                addMessage('Xin chào! Tôi là trợ lý AI của cửa hàng laptop. Tôi có thể giúp gì cho bạn?', 'bot');
                welcomeMessageShown = true;
            }
        }
    }

    function closeChathanlde() {
        chatContainer.addClass('hidden');
    }

    function handleClickOutside(event) {
        if (!chatContainer.hasClass('hidden') &&
            !$(event.target).closest(chatContainer).length &&
            !$(event.target).closest(chatButton).length) {
            chatContainer.addClass('hidden');
        }
    }

    function handleKeyPress(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            sendMessage();
        }
    }

    function handleTyping() {
        clearTimeout(typingTimer);
        if (!isTyping) {
            isTyping = true;
            updateTypingIndicator(true);
        }

        typingTimer = setTimeout(() => {
            isTyping = false;
            updateTypingIndicator(false);
        }, typingDelay);
    }

    function updateTypingIndicator(isTyping) {
        const typingIndicator = chatMessages.find('.typing-indicator');
        if (isTyping && !typingIndicator.length) {
            addTypingIndicator();
        } else if (!isTyping && typingIndicator.length) {
            typingIndicator.remove();
        }
    }

    function addTypingIndicator() {
        const indicator = $('<div>')
            .addClass('message bot-message typing-indicator')
            .html('<div class="loading-dots"><span></span><span></span><span></span></div>');
        chatMessages.append(indicator);
        scrollToBottom();
    }

    function sendMessage() {
        const message = userInput.val().trim();
        if (!message) return;

        addMessage(message, 'user');
        const loadingDiv = showLoading();
        userInput.val('').prop('disabled', true);
        sendButton.prop('disabled', true);

        $.ajax({
            url: 'https://043f-104-154-82-216.ngrok-free.app/api/chat',
            method: 'POST',
            contentType: 'application/json',
            crossDomain: true,
            data: JSON.stringify({ message: message }),
            success: function (data) {
                handleResponse(data, loadingDiv);
            },
            error: function (error) {
                handleError(error, loadingDiv);
            },
            complete: function () {
                userInput.prop('disabled', false).focus();
                sendButton.prop('disabled', false);
            }
        });
    }

    function handleResponse(data, loadingDiv) {
        removeLoading(loadingDiv);
        if (data.response) {
            addMessage(data.response, 'bot');
        } else {
            addMessage('Xin lỗi, tôi không thể xử lý câu hỏi này.', 'bot');
        }
    }

    function handleError(error, loadingDiv) {
        console.error('Error details:', error);
        removeLoading(loadingDiv);
        addMessage('Đã xảy ra lỗi khi xử lý yêu cầu của bạn. Vui lòng thử lại sau.', 'bot');
    }

    function addMessage(text, sender) {
        const messageDiv = $('<div>')
            .addClass(`message ${sender}-message`)
            .html(formatMessage(text));

        const timestamp = $('<div>')
            .addClass('message-timestamp')
            .text(formatTimestamp(new Date()));

        messageDiv.append(timestamp);
        chatMessages.append(messageDiv);
        scrollToBottom();
    }

    function formatMessage(text) {
        // Convert URLs to clickable links
        return text.replace(/(https?:\/\/[^\s]+)/g, '<a href="$1" target="_blank">$1</a>');
    }

    function formatTimestamp(date) {
        return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    }

    function showLoading() {
        const loadingDiv = $('<div>')
            .addClass('message bot-message loading')
            .html('<div class="loading-dots"><span></span><span></span><span></span></div>');
        chatMessages.append(loadingDiv);
        scrollToBottom();
        return loadingDiv;
    }

    function removeLoading(loadingDiv) {
        if (loadingDiv && loadingDiv.length) {
            loadingDiv.remove();
        }
    }

    function scrollToBottom() {
        chatMessages.stop().animate({
            scrollTop: chatMessages[0].scrollHeight
        }, 300);
    }
});