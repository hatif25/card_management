<?php
// Include your database connection function here
require_once 'dbconnection.php';

// Function to fetch expenses data for a specific username
function fetchExpenses($loggedInUsername) {
    $connection = dbconnection(); // Connect to the database

    // Check if the connection is successful
    if (!$connection) {
        return array("error" => "Database connection failed");
    }

    // Fetch card numbers associated with the logged-in username
    $cardNos = array();
    $sql = "SELECT card_number FROM card WHERE uname='$loggedInUsername'";
    $result = mysqli_query($connection, $sql);
    while ($row = mysqli_fetch_assoc($result)) {
        $cardNos[] = $row['card_number'];
    }
    mysqli_free_result($result);

    // Prepare the SQL statement to fetch expenses for these card numbers
    $cardNosString = implode("','", $cardNos);
    $sql = "SELECT trsn_id, payee, category, amount, date_of_payment FROM transaction WHERE card_no IN ('$cardNosString')";

    // Execute the query
    $result = mysqli_query($connection, $sql);

    // Check if the query was successful
    if (!$result) {
        return array("error" => "Failed to fetch expenses data");
    }

    // Fetch data into an associative array
    $expenses = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $expenses[] = $row;
    }

    // Free result set
    mysqli_free_result($result);

    // Close the database connection
    mysqli_close($connection);

    // Return fetched expenses data
    return $expenses;
}

// Check if the username is provided in the request
if (isset($_GET['uname'])) {
    $loggedInUsername = $_GET['uname'];

    // Retrieve expenses data for the specified username
    $expensesData = fetchExpenses($loggedInUsername);

    // Check if any error occurred
    if (isset($expensesData["error"])) {
        // Send error response
        http_response_code(500); // Internal Server Error
        echo json_encode(array("error" => $expensesData["error"]));
    } else {
        // Send success response with expenses data
        echo json_encode($expensesData);
    }
} else {
    // Username not provided in the request
    http_response_code(400); // Bad Request
    echo json_encode(array("error" => "Username not provided"));
}
?>
