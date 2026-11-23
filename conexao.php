<?php
$servername = "localhost";
$username = "root";
$password = "1234";
$dbname = "db_biblioteca";

// Criar a conexão
$conn = new mysqli($servername, $username, $password, $dbname);

// Checar conexão
if ($conn->connect_error) {
    die("Falha na conexão com o banco de dados: " . $conn->connect_error);
}

// Configurar codificação
$conn->set_charset("utf8mb4");
?>
