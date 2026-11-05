<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Login</title>

    <link rel="stylesheet" href="login.css">
</head>

<body>

<div class="login-box">

    <h2>Student Login</h2>

    <form action="LoginServlet" method="post">

        <label>Email</label>

        <input type="email"
               name="email"
               placeholder="Enter Email"
               required>

        <label>Password</label>

        <input type="password"
               name="password"
               placeholder="Enter Password"
               required>

        <input type="submit"
               value="Login">

    </form>

</div>

</body>
</html>