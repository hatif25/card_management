<?php
require_once 'dbconnection.php';

function insertTransactionDetails($trsn_id, $cardNumber, $dateOfPayment, $amount, $payee, $category) {
    $connection = dbconnection(); 

    if (!$connection) {
        return array("error" => "Database connection failed");
    }

    $sql = "INSERT INTO transaction (trsn_id, card_no, date_of_payment, amount, payee, category) 
            VALUES (?, ?, ?, ?, ?, ?)";

    $statement = mysqli_prepare($connection, $sql);
    if (!$statement) {
        return array("error" => "Error preparing SQL statement: " . mysqli_error($connection));
    }

    mysqli_stmt_bind_param($statement, "ssssss", $trsn_id, $cardNumber, $dateOfPayment, $amount, $payee, $category);

    $success = mysqli_stmt_execute($statement);
    if (!$success) {
        return array("error" => "Error executing SQL statement: " . mysqli_stmt_error($statement));
    }

    $trsn_id = mysqli_insert_id($connection); // Retrieve the last inserted trsn_id

    mysqli_stmt_close($statement);
    mysqli_close($connection);

    return array("success" => "Transaction details inserted successfully", "trsn_id" => $trsn_id);
}

$data = json_decode(file_get_contents("php://input"), true);

if (
    isset($data['trsn_id']) &&
    isset($data['cardNumber']) &&
    isset($data['dateOfPayment']) &&
    isset($data['amount']) &&
    isset($data['payee']) &&
    isset($data['category'])
) {
    $result = insertTransactionDetails(
        $data['trsn_id'],
        $data['cardNumber'],
        $data['dateOfPayment'],
        $data['amount'],
        $data['payee'],
        $data['category']
    );

    if (isset($result["error"])) {
        http_response_code(500);
        echo json_encode(array("error" => $result["error"]));
    } else {
        http_response_code(200);
        echo json_encode(array("success" => "Transaction details inserted successfully", "trsn_id" => $result["trsn_id"]));
    }
} else {
    http_response_code(400);
    echo json_encode(array("error" => "Missing required fields"));
}
?>
