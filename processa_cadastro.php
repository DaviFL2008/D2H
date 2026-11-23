
<?php
session_start();

require_once __DIR__ . "/conexao.php";

// Aceitar somente envios pelo método POST
if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    header("Location: Cadastro.html");
    exit();
}

// Receber os dados do formulário
$nome = trim($_POST["nome"] ?? "");
$email = trim($_POST["email"] ?? "");
$cpf = preg_replace('/\D/', '', $_POST["cpf"] ?? "");
$senha = $_POST["senha"] ?? "";
$confirmarSenha = $_POST["confirmar-senha"] ?? "";

// Validar os campos
if (
    $nome === "" ||
    !filter_var($email, FILTER_VALIDATE_EMAIL) ||
    strlen($cpf) !== 11 ||
    $senha === "" ||
    $senha !== $confirmarSenha
) {
    exit("Dados inválidos. Confira o nome, e-mail, CPF e as senhas.");
}

if (strlen($senha) < 8) {
    exit("A senha deve ter pelo menos 8 caracteres.");
}

// Verificar se e-mail ou CPF já estão cadastrados
$sql = "SELECT id_usuario FROM usuarios
        WHERE email = ?
        OR REPLACE(REPLACE(REPLACE(cpf, '.', ''), '-', ''), ' ', '') = ?
        LIMIT 1";

$stmt = mysqli_prepare($conn, $sql);

if (!$stmt) {
    exit("Erro ao preparar a consulta: " . mysqli_error($conn));
}

mysqli_stmt_bind_param($stmt, "ss", $email, $cpf);
mysqli_stmt_execute($stmt);
$resultado = mysqli_stmt_get_result($stmt);

if (mysqli_num_rows($resultado) > 0) {
    mysqli_stmt_close($stmt);
    exit("Este e-mail ou CPF já está cadastrado.");
}

mysqli_stmt_close($stmt);

// Proteger a senha antes de salvar
$senhaHash = password_hash($senha, PASSWORD_DEFAULT);

// Inserir o usuário na tabela correta
$sql = "INSERT INTO usuarios (nome, email, cpf, senha)
        VALUES (?, ?, ?, ?)";

$stmt = mysqli_prepare($conn, $sql);

if (!$stmt) {
    exit("Erro ao preparar o cadastro: " . mysqli_error($conn));
}

mysqli_stmt_bind_param($stmt, "ssss", $nome, $email, $cpf, $senhaHash);

if (mysqli_stmt_execute($stmt)) {
    mysqli_stmt_close($stmt);
    header("Location: login.html?cadastro=sucesso");
    exit();
}

$erro = mysqli_stmt_error($stmt);
mysqli_stmt_close($stmt);

if (mysqli_errno($conn) == 1062) {
    exit("Este e-mail ou CPF já está cadastrado.");
}

exit("Não foi possível cadastrar o usuário: " . $erro);
?>
