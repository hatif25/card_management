<?php
// Include the database connection function
include 'dbconnection.php';

// Retrieve filter parameters from POST request
$filterStartDate = isset($_POST['startDate']) ? $_POST['startDate'] : null;
$filterEndDate = isset($_POST['endDate']) ? $_POST['endDate'] : null;
$filterCategory = isset($_POST['category']) ? $_POST['category'] : null;
$filterAmountStart = isset($_POST['amountStart']) ? $_POST['amountStart'] : null;
$filterAmountEnd = isset($_POST['amountEnd']) ? $_POST['amountEnd'] : null;
$filterPayee = isset($_POST['payee']) ? $_POST['payee'] : null;

// Retrieve the username of the currently logged-in user
$loggedInUsername = isset($_POST['uname']) ? $_POST['uname'] : null;

// Establish database connection
$conn = dbconnection();

// Check if the connection is successful
if (!$conn) {
    // If connection fails, return an error response
    http_response_code(500); // Internal Server Error
    echo json_encode(array("error" => "Database connection failed"));
    exit; // Exit the script
}

// Retrieve card number(s) associated with the logged-in username
$cardNumbers = array();
$sqlCard = "SELECT card_number FROM card WHERE uname='$loggedInUsername'";
$resultCard = $conn->query($sqlCard);

// Check if there are any associated card numbers
if ($resultCard->num_rows > 0) {
    // Fetch card numbers into an array
    while ($rowCard = $resultCard->fetch_assoc()) {
        $cardNumbers[] = $rowCard['card_number'];
    }

    // Close the result set
    $resultCard->close();
} else {
    // If no associated card numbers found, return an empty response
    echo json_encode(array());
    exit; // Exit the script
}

// Prepare the SQL query to filter expenses based on card number(s) and other filters
$sql = "SELECT trsn_id, payee, category, amount, date_of_payment FROM transaction WHERE ";

// Construct the condition to filter expenses based on card number(s)
$sql .= " card_no IN ('" . implode("','", $cardNumbers) . "')";

// Add other filters based on provided parameters
if ($filterStartDate) {
    $sql .= " AND date_of_payment >= '$filterStartDate'";
}
if ($filterEndDate) {
    $sql .= " AND date_of_payment <= '$filterEndDate'";
}
if ($filterCategory) {
    $sql .= " AND category = '$filterCategory'";
}
if ($filterAmountStart) {
    $sql .= " AND amount >= '$filterAmountStart'";
}
if ($filterAmountEnd) {
    $sql .= " AND amount <= '$filterAmountEnd'";
}
if ($filterPayee) {
    $sql .= " AND payee LIKE '%$filterPayee%'";
}

// Execute the SQL query
$result = $conn->query($sql);

// Fetch result rows as an associative array
$expenses = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $expenses[] = $row;
    }
}

// Return JSON response containing filtered transactions
header('Content-Type: application/json');
echo json_encode($expenses);

// Close database connection
$conn->close();
?>