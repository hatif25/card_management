<?php
require_once 'dbconnection.php';

function fetchCardDetails($username) {
    $connection = dbconnection();

    if (!$connection) {
        return array("error" => "Database connection failed");
    }

    // Sanitize the username to prevent SQL injection
    $username = mysqli_real_escape_string($connection, $username);

    // Modify the SQL query to filter by username
    $sql = "SELECT card_number, expiry_date, card_holder_name, bankName FROM card WHERE uname='$username'";

    $result = mysqli_query($connection, $sql);

    if (!$result) {
        return array("error" => "Failed to fetch card details");
    }

    $cardDetails = array();

    while ($row = mysqli_fetch_assoc($result)) {
        $cardDetails[] = array(
            "cardNumber" => $row["card_number"],
            "expiryDate" => $row["expiry_date"],
            "cardHolderName" => $row["card_holder_name"],
            "bankName" => $row["bankName"]
        );
    }

    mysqli_close($connection);

    return $cardDetails;
}

// Get the username from the request
$username = $_GET['uname'];

$cardDetails = fetchCardDetails($username);

if (isset($cardDetails["error"])) {
    http_response_code(500);
    echo json_encode(array("error" => $cardDetails["error"]));
} else {
    echo json_encode($cardDetails);
}
?>