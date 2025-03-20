<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <head>

            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
            <link rel="shortcut icon" type="image/x-icon" href="/client/images/general/favicon.ico" />
            <meta name="description" content="">
            <meta name="author" content="">

            <title>
                ${param.pageTitle} - Quản trị ST Laptop
            </title>
            <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
            <!-- Custom fonts for this template-->
            <link href="<c:url value="/store/vendor/fontawesome-free/css/all.min.css"/>" rel="stylesheet" type="text/css">
            <link
                href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
                rel="stylesheet">

            <!-- Custom styles for this template-->
            <link href="<c:url value="/store/css/sb-admin-2.min.css"/>" rel="stylesheet">
            <link href="<c:url value="/store/css/custom.css"/>" rel="stylesheet">

            <!-- Custom styles for this page -->
            <link href="<c:url value="/store/vendor/datatables/dataTables.bootstrap4.min.css"/>" rel="stylesheet">

                <script src="<c:url value='/ckeditor/ckeditor.js' />"></script>
                <script>
                    var editor = '';
                    $(document).ready(function () {
                        editor = CKEDITOR.replace('description');
                    });
                </script>
        </head>