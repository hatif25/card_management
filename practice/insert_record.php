<?php
include_once 'dbconnection.php'; 

header('Content-Type: application/json'); // Set the content type to JSON

$response = array(); // Initialize response array

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $conn = dbconnection();

    $uname = $_POST['uname'];
    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $email = $_POST['email'];
    $phone = $_POST['phone'];
    $password = $_POST['password']; 

    $sql = "INSERT INTO user (uname, fname, lname, email, phone, password) 
            VALUES ('$uname', '$fname', '$lname', '$email', '$phone', '$password')";
    
    if ($conn->query($sql) === TRUE) {
        // Registration successful
        $response['success'] = true;
        $response['message'] = "Registration successful";
    } else {
        // Registration failed
        $response['success'] = false;
        $response['message'] = "Error: " . $sql . "<br>" . $conn->error;
    }

    $conn->close();

    // Return the response as JSON
    echo json_encode($response);
}
?>
