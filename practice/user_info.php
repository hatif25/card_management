<?php
// Include the database connection file
include 'dbconnection.php';

// Assuming loggedInUsername is passed as a POST parameter
$loggedInUsername = $_POST['uname'];

// Prepare SQL statement to fetch user info
$sql = "SELECT fname, lname, email FROM user WHERE uname = hatif25";

// Prepare statement
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $loggedInUsername);

// Execute statement
$stmt->execute();

// Bind result variables
$stmt->bind_result($fname, $lname, $email);

// Fetch values
if ($stmt->fetch()) {
    // User found, return the data as JSON
    $response = array(
        'fname' => $fname,
        'lname' => $lname,
        'email' => $email
    );
    echo json_encode($response);
} else {
    // User not found
    echo json_encode(array('error' => 'User not found'));
}

// Close statement and database connection
$stmt->close();
$conn->close();
?>
