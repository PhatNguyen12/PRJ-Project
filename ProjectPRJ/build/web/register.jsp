<%-- 
    Document   : register.jsp
    Created on : Jul 17, 2024, 11:05:18 AM
    Author     : My Computer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }

        .container h2 {
            margin-bottom: 20px;
        }

        .container input[type="text"], 
        .container input[type="password"], 
        .container input[type="email"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .container input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
            margin-top: 10px;
        }

        .container input[type="submit"]:hover {
            background-color: #45a049;
        }

        .container .error-message {
            color: red;
            margin-bottom: 10px;
        }

        .container a {
            display: block;
            margin-top: 20px;
            text-decoration: none;
            color: #4CAF50;
        }

        .container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register</h2>
        <form action="authen?action=register" method="post">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <input type="email" name="email" placeholder="Email" required><br>
            <span class="error-message">${errorMessage}</span><br>
            <input type="submit" value="Register">
        </form>
        <a href="login.jsp">Already have an account? Login here.</a>
    </div>
</body>
</html>
