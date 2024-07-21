<?php
function dbconnection()
{
    $con=mysqli_connect("localhost","root","","card_management");
    return $con;
}
?>