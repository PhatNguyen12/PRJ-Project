<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.10.21/css/dataTables.bootstrap4.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .navbar {
            margin-bottom: 20px;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .action-btns {
            margin-bottom: 20px;
        }
        .action-buttons {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <div class="container">
        <h2 class="mb-4">Document Management</h2>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" role="alert">
                ${errorMessage}
            </div>
        </c:if>
        <div class="action-btns">
            <button class="btn btn-success" data-toggle="modal" data-target="#createModal">Create New Document</button>
        </div>
        <table id="documentsTable" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Document ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Upload Date</th>
                    <th>Document Type</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${documents}" var="document">
                    <tr>
                        <td>${document.getDocumentID()}</td>
                        <td><a href="${pageContext.request.contextPath}/DownloadServlet?fileName=${document.getFilePath().substring(document.getFilePath().lastIndexOf('/') + 1)}">${document.getTitle()}</a></td>
                        <td>${document.getDescription()}</td>
                        <td>${document.getUploadDate()}</td>
                        <td>
                            <c:forEach items="${documentTypes}" var="documentType">
                                <c:if test="${document.getDocumentTypeID() == documentType.getId()}">
                                    ${documentType.getName()}
                                </c:if>
                            </c:forEach>
                        </td>
                        <td class="action-buttons">
                            <button class="btn btn-primary btn-edit" data-toggle="modal" data-target="#editModal"
                                data-id="${document.getDocumentID()}"
                                data-title="${document.getTitle()}"
                                data-description="${document.getDescription()}"
                                data-uploaddate="${document.getUploadDate()}"
                                data-documenttypeid="${document.getDocumentTypeID()}">
                                Edit
                            </button>
                            <button class="btn btn-danger btn-delete" data-id="${document.getDocumentID()}" data-title="${document.getTitle()}">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Modal để tạo tài liệu mới -->
    <div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createModalLabel">Create New Document</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="createForm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/createDocument" method="post">
                        <div class="form-group">
                            <label for="createTitle">Title</label>
                            <input type="text" class="form-control" id="createTitle" name="title">
                        </div>
                        <div class="form-group">
                            <label for="createDescription">Description</label>
                            <textarea class="form-control" id="createDescription" name="description"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="createUploadDate">Upload Date</label>
                            <input type="datetime-local" class="form-control" id="createUploadDate" name="uploadDate">
                        </div>
                        <div class="form-group">
                            <label for="createDocumentTypeID">Document Type</label>
                            <select class="form-control" id="createDocumentTypeID" name="documentTypeID">
                                <c:forEach items="${documentTypes}" var="documentType">
                                    <option value="${documentType.getId()}">${documentType.getName()}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="createFile">Upload File</label>
                            <input type="file" class="form-control-file" id="createFile" name="file">
                            <small id="createFileName" class="form-text text-muted"></small>
                        </div>
                        <button type="submit" class="btn btn-primary">Create</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal để chỉnh sửa tài liệu -->
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Document</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="editForm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/EditDocumentServlet" method="post">
                        <input type="hidden" id="documentID" name="documentID">
                        <div class="form-group">
                            <label for="title">Title</label>
                            <input type="text" class="form-control" id="title" name="title">
                        </div>
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea class="form-control" id="description" name="description"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="uploadDate">Upload Date</label>
                            <input type="datetime-local" class="form-control" id="uploadDate" name="uploadDate">
                        </div>
                        <div class="form-group">
                            <label for="documentTypeID">Document Type</label>
                            <select class="form-control" id="documentTypeID" name="documentTypeID">
                                <c:forEach items="${documentTypes}" var="documentType">
                                    <option value="${documentType.getId()}">${documentType.getName()}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="file">Upload New File</label>
                            <input type="file" class="form-control-file" id="file" name="file">
                            <small id="fileName" class="form-text text-muted"></small>
                        </div>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal để xác nhận xóa tài liệu -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Delete Document</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete this document?</p>
                    <p id="deleteDocumentTitle"></p>
                </div>
                <div class="modal-footer">
                    <form id="deleteForm" action="${pageContext.request.contextPath}/DeleteDocumentServlet" method="post">
                        <input type="hidden" id="deleteDocumentID" name="documentID">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#documentsTable').DataTable();

            // Sự kiện khi nút Edit được nhấn
            $('.btn-edit').on('click', function() {
                var documentID = $(this).data('id');
                var title = $(this).data('title');
                var description = $(this).data('description');
                var uploadDate = $(this).data('uploaddate');
                var documentTypeID = $(this).data('documenttypeid');

                // Chuyển đổi định dạng ngày tháng sang định dạng 'YYYY-MM-DDTHH:MM' cho datetime-local input
                var date = new Date(uploadDate);
                var dateStr = date.toISOString().slice(0, 16);

                // Điền dữ liệu vào form trong modal
                $('#documentID').val(documentID);
                $('#title').val(title);
                $('#description').val(description);
                $('#uploadDate').val(dateStr);
                $('#documentTypeID').val(documentTypeID);
            });

            // Hiển thị tên file khi chọn file mới (Edit)
            $('#file').on('change', function() {
                var fileName = $(this).val().split('\\').pop();
                $('#fileName').text(fileName);
            });

            // Hiển thị tên file khi chọn file mới (Create)
            $('#createFile').on('change', function() {
                var fileName = $(this).val().split('\\').pop();
                $('#createFileName').text(fileName);
            });

            // Sự kiện khi nút Delete được nhấn
            $('.btn-delete').on('click', function() {
                var documentID = $(this).data('id');
                var title = $(this).data('title');

                // Điền dữ liệu vào form trong modal
                $('#deleteDocumentID').val(documentID);
                $('#deleteDocumentTitle').text(title);

                // Hiển thị modal xác nhận xóa
                $('#deleteModal').modal('show');
            });
        });
    </script>
</body>
</html>
