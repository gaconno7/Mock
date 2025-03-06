<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <!-- Delete User Modal-->
        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
            aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">
                            Bạn muốn xoá ${param.entity} <span id="entityName" class="text-danger"></span>?
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">Bấm nút "Xác nhận xoá" ở dưới nếu bạn muốn xoá ${param.entity}
                        này và những thông tin liên quan.
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Tôi không
                            muốn</button>
                        <form method="post" action="/admin/${param.actionSubfolder}/delete"
                            modelAttribute="${param.modalAttribute}">
                            <input type="hidden" name="id" value="" class="form-control" path="id" />
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <button class="btn btn-danger">Xác nhận xoá</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>