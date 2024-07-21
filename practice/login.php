<?php
include_once 'dbconnection.php'; // Include the database connection file

// Initialize message variable
$message = "";

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Establish database connection
    $conn = dbconnection();

    // Retrieve form data and sanitize inputs
    $uname = mysqli_real_escape_string($conn, $_POST['uname']);
    $password = mysqli_real_escape_string($conn, $_POST['password']);

    // Fetch user data from the database based on username
    $sql = "SELECT * FROM user WHERE uname='$uname'";
    $result = $conn->query($sql);

    if ($result) {
        // Check if user exists
        if ($result->num_rows > 0) {
            // User found, verify password
            $row = $result->fetch_assoc();
            if ($password === $row['password']) {
                // Password is correct, login successful
                $message = "Login successful";
                echo json_encode(array("success" => true, "message" => $message));
            } else {
                $message = "Incorrect password";
                echo json_encode(array("success" => false, "error" => $message));
            }
        } else {
            $message = "User not found";
            echo json_encode(array("success" => false, "error" => $message));
        }
    } else {
        // Error executing SQL query
        $message = "Error: " . $conn->error;
        echo json_encode(array("success" => false, "error" => $message));
    }

    // Close the database connection
    $conn->close();
}
?>
