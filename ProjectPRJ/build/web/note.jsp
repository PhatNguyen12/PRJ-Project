<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Notes</title>
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
        <h2 class="mb-4">Text</h2>
        <div class="action-btns">
            <button class="btn btn-success" data-toggle="modal" data-target="#createModal">Create New Note</button>
        </div>
        <table id="notesTable" class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Note ID</th>
                    <th>Title</th>
                    <th>Note</th>
                    <th>Created Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${notes}" var="note">
                    <tr>
                        <td>${note.getId()}</td>
                        <td>${note.getTitle()}</td>
                        <td>${note.getNote()}</td>
                        <td>${note.getCreateDate()}</td>
                        <td class="action-buttons">
                            <button class="btn btn-primary btn-edit" data-toggle="modal" data-target="#editModal"
                                data-id="${note.getId()}"
                                data-title="${note.getTitle()}"
                                data-note="${note.getNote()}"
                                data-createdate="${note.getCreateDate()}">
                                Edit
                            </button>
                            <button class="btn btn-danger btn-delete" data-id="${note.getId()}" data-title="${note.getTitle()}" data-note="${note.getNote()}">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Modal to create a new note -->
    <div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createModalLabel">Create New Note</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="createForm" action="${pageContext.request.contextPath}/notes?action=create" method="post">
                        <div class="form-group">
                            <label for="createTitle">Title</label>
                            <input type="text" class="form-control" id="createTitle" name="title" required>
                        </div>
                        <div class="form-group">
                            <label for="createNote">Note</label>
                            <textarea class="form-control" id="createNote" name="note" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Create</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal to edit a note -->
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Note</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="editForm" action="${pageContext.request.contextPath}/notes?action=edit" method="post">
                        <input type="hidden" id="noteID" name="noteID">
                        <div class="form-group">
                            <label for="title">Title</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="form-group">
                            <label for="note">Note</label>
                            <textarea class="form-control" id="note" name="note" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal to confirm deleting a note -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Delete Note</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete this note?</p>
                    <p id="deleteNoteText"></p>
                </div>
                <div class="modal-footer">
                    <form id="deleteForm" action="${pageContext.request.contextPath}/notes?action=delete" method="post">
                        <input type="hidden" id="deleteNoteID" name="noteID">
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
            $('#notesTable').DataTable();

            // Event handler for the Edit button
            $('.btn-edit').on('click', function() {
                var noteID = $(this).data('id');
                var title = $(this).data('title');
                var note = $(this).data('note');
                var createDate = $(this).data('createdate');

                // Populate the form fields in the Edit modal
                $('#noteID').val(noteID);
                $('#title').val(title);
                $('#note').val(note);
            });

            // Event handler for the Delete button
            $('.btn-delete').on('click', function() {
                var noteID = $(this).data('id');
                var title = $(this).data('title');
                var noteText = $(this).data('note');

                // Populate the form field in the Delete modal
                $('#deleteNoteID').val(noteID);
                $('#deleteNoteText').text(title + ": " + noteText);

                // Show the Delete modal
                $('#deleteModal').modal('show');
            });
        });
    </script>
</body>
</html>
