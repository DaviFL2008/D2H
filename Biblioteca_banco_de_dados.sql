
USE db_biblioteca;

-- 1. Tabela de Editoras
CREATE TABLE editoras (
    id_editora INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50)
);

-- 1. Consultar Editoras
SELECT * FROM editoras;

-- 2. Tabela de Autores
CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)
);

-- 2. Consultar Autores
SELECT * FROM autores;

-- 3. Tabela de Livros
CREATE TABLE livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    ano_publicacao INT,
    id_editora INT,
    FOREIGN KEY (id_editora) REFERENCES editoras(id_editora) ON DELETE SET NULL
);

-- 3. Consultar Livros
SELECT * FROM livros;

-- 4. Tabela de Relacionamento entre Livros e Autores (Muitos-para-Muitos)
CREATE TABLE livro_autor (
    id_livro INT,
    id_autor INT,
    PRIMARY KEY (id_livro, id_autor),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro) ON DELETE CASCADE,
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor) ON DELETE CASCADE
);

-- 4. Consultar Relação entre Livros e Autores
SELECT * FROM livro_autor;

-- 5. Tabela de Usuários/Leitores (Com CPF e Senha compatíveis com o PHP de cadastro)
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- 5. Consultar Usuários (agora com CPF e Senha)
SELECT * FROM usuarios;

-- 6. Tabela de Empréstimos
CREATE TABLE emprestimos (
    id_emprestimo INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    data_emprestimo DATE NOT NULL DEFAULT (CURRENT_DATE),
    data_devolucao_prevista DATE NOT NULL,
    data_devolucao_real DATE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- 6. Consultar Empréstimos
SELECT * FROM emprestimos;

-- 7. Tabela de Itens Emprestados (Relacionamento entre Empréstimos e Livros)
CREATE TABLE itens_emprestimo (
    id_emprestimo INT,
    id_livro INT,
    PRIMARY KEY (id_emprestimo, id_livro),
    FOREIGN KEY (id_emprestimo) REFERENCES emprestimos(id_emprestimo) ON DELETE CASCADE,
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro) ON DELETE CASCADE
);

-- 7. Consultar Itens dos Empréstimos
SELECT * FROM itens_emprestimo;