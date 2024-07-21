<?php
require_once 'dbconnection.php';

function insertCardDetails($uname, $cardNumber, $expiryDate, $cardHolderName, $bankName) {
    $connection = dbconnection();

    if (!$connection) {
        return array("error" => "Database connection failed");
    }

    $sql = "INSERT INTO card (uname, card_number, expiry_date, card_holder_name, bankName) 
            VALUES (?, ?, ?, ?, ?)";

    $statement = mysqli_prepare($connection, $sql);

    if (!$statement) {
        return array("error" => "Error in preparing SQL statement: " . mysqli_error($connection));
    }

    mysqli_stmt_bind_param($statement, "sssss", $uname, $cardNumber, $expiryDate, $cardHolderName, $bankName);

    $success = mysqli_stmt_execute($statement);

    if (!$success) {
        return array("error" => "Failed to execute SQL statement: " . mysqli_error($connection));
    }

    mysqli_stmt_close($statement);
    mysqli_close($connection);

    return array("success" => "Card details inserted successfully");
}

$data = json_decode(file_get_contents("php://input"), true);

if (
    isset($data['uname']) &&
    isset($data['cardNumber']) &&
    isset($data['expiry']) &&
    isset($data['name']) &&
    isset($data['bankName'])
) {
    $result = insertCardDetails(
        $data['uname'],
        $data['cardNumber'],
        $data['expiry'],
        $data['name'],
        $data['bankName']
    );

    if (isset($result["error"])) {
        http_response_code(500);
        echo json_encode(array("error" => $result["error"]));
    } else {
        echo json_encode(array("success" => "Card details inserted successfully"));
    }
} else {
    http_response_code(400);
    echo json_encode(array("error" => "Missing required fields"));
}
?>
