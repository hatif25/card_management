<?php
require_once 'dbconnection.php';

function fetchTransactionDetails($trsn_id) {
    $connection = dbconnection(); 

    if (!$connection) {
        return array("error" => "Database connection failed");
    }

    // Prepare SQL statement with a parameterized query to prevent SQL injection
    $sql = "SELECT * FROM transaction WHERE trsn_id = ?";
    $statement = mysqli_prepare($connection, $sql);
    mysqli_stmt_bind_param($statement, "s", $trsn_id);
    mysqli_stmt_execute($statement);
    $result = mysqli_stmt_get_result($statement);

    if (!$result) {
        return array("error" => "Error executing SQL statement: " . mysqli_error($connection));
    }

    $transactionDetails = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $transactionDetails[] = $row;
    }

    mysqli_free_result($result);
    mysqli_close($connection);

    return $transactionDetails;
}

// Check if trsn_id is provided in the request
if (isset($_GET['trsn_id'])) {
    $trsn_id = $_GET['trsn_id'];
    // Call the function to fetch transaction details with the provided trsn_id
    $transactionDetails = fetchTransactionDetails($trsn_id);
} else {
    $transactionDetails = array("error" => "Transaction ID (trsn_id) not provided");
}

// Send response based on the result
if (isset($transactionDetails["error"])) {
    http_response_code(500);
    echo json_encode(array("error" => $transactionDetails["error"]));
} else {
    http_response_code(200);
    echo json_encode($transactionDetails);
}
?>
