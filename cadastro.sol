/*
SPDX-License-Identifier: CC-BY-4.0
(c) Desenvolvido por Eder Ribeiro
This work is licensed under a Creative Commons Attribution 4.0 International License.
*/
pragma solidity 0.8.19;

/// @author Eder Ribeiro
/// @title Contrato que faz cadastro de uma pessoa
/// Contract Address 1: 0x5db5eaf3320b8daade0a3baabc860328326f0337 (Teste de envento com struct)
/// Contract Address 2: 0x1a019a5c8b8442f69c86a679ca8fa09534debd12
contract Cadastro {
    struct Pessoa {
        address addresss;
        string nome;
        uint anoNascimento;
        uint idadeNoCadastro;
    }

    // ref: https://ethereum.stackexchange.com/questions/132708/how-to-get-current-year-from-timestamp-solidity
    uint anoAtual = (block.timestamp / 31557600) + 1970;

    mapping(address => Pessoa) public cadastro;

    Pessoa[] private pessoas;

    event DetalheCadastro(address quemFez, string nome, uint anoNascimento);

    // @notice Cadastra uma pessoa
    // @dev Cadastra uma pessoa, calcula sua idade e salva a data hora da inclusao do registro
    function cadastrar(string memory nome, uint anoNascimento) public {
        Pessoa memory pessoa = Pessoa(
            msg.sender,
            nome,
            anoNascimento,
            anoAtual - anoNascimento
        );
        pessoas.push(pessoa);
        cadastro[msg.sender] = pessoa;
        emit DetalheCadastro(msg.sender, pessoa.nome, pessoa.anoNascimento);
    }

    // @notice Retorna lista de pessoas cadastradas
    // @dev Retorna lista de pessoas cadastradas, caso exista
    // @return Lista de pessoas cadastradas
    function listaCadastros() public view returns (Pessoa[] memory) {
        require(pessoas.length != 0, "Nenhum cadastro encontrado.");
        return pessoas;
    }
}
