const bodyParser = require("body-parser"); // Importa o módulo body-parser, que é usado para analisar o corpo das solicitações HTTP.
const express = require("express"); // Importa o módulo Express.js, que é usado para criar o servidor web.
const { Pool } = require("pg"); // Importa a classe Pool do módulo pg, que é usado para interagir com o PostgreSQL.

const app = express(); // Cria uma nova aplicação Express.js.
const pool = new Pool({
  // Cria uma nova pool de conexões para o PostgreSQL.
  host: "database", // O hostname do banco de dados PostgreSQL.
  database: "unitins", // O nome do banco de dados.
  user: "postgres", // O nome do usuário do banco de dados.
  password: "XidErsEntLET", // A senha do usuário do banco de dados.
});

app.use(bodyParser.urlencoded({ extended: true })); // Configura a aplicação para usar o middleware body-parser para analisar o corpo das solicitações HTTP.

app.get("/", async (req, res) => {
  // Define uma rota GET na raiz ("/").
  const client = await pool.connect(); // Conecta-se ao banco de dados.
  const result = await client.query("SELECT * FROM cliente"); // Executa uma consulta SQL para obter todos os registros da tabela cliente.
  const results = { results: result ? result.rows : null }; // Prepara os resultados para serem enviados como resposta.
  res.send(results); // Envia os resultados como resposta.
  client.release(); // Libera a conexão de volta para a pool.
});

app.post("/cliente", async (req, res) => {
  // Define uma rota POST em "/cliente".
  const { nome, idade } = req.body; // Extrai os campos nome e idade do corpo da solicitação.
  const client = await pool.connect(); // Conecta-se ao banco de dados.
  await client.query("INSERT INTO cliente (nome, idade) VALUES ($1, $2)", [
    nome,
    idade,
  ]); // Executa uma consulta SQL para inserir um novo registro na tabela cliente.
  res.send("Cliente adicionado com sucesso!"); // Envia uma mensagem de sucesso como resposta.
  client.release(); // Libera a conexão de volta para a pool.
});

app.listen(3000, () => console.log("Listening on port 3000")); // Inicia o servidor na porta 3000.
