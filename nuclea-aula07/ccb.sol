// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.19;

import "./owner.sol";
import "./titulo.sol";

/**
 * @title CCB (Cédula de Crédito Bancário)
 * @dev Operacoes de uma CCB
 * @author Eder Ribeiro
 */
 contract CCBSimples is Titulo, Owner {

    string _credor;
    string _cnpjCredor;
    string _emitente;
    string _cpfEmitente;
    uint256 immutable _dataEmissao;
    uint256 _valor;
    uint256 _prazoPagamento;

    constructor() {
        _credor = "BANCO BTG PACTUAL S.A.";
        _cnpjCredor = "30.306.294/0001-45";
        _emitente = "Eder Ribeiro";
        _cpfEmitente = "308.xxx.968-xx";
        _dataEmissao = block.timestamp;
        _valor = 100000000;
        _prazoPagamento = _dataEmissao + 90 days;
        emit NovoPrazoPagamento(_dataEmissao, _prazoPagamento);
    }

    /**
     * @dev Retorna o valor nominal.
     */
    function valorNominal() external view returns (uint256) {
        return _valor;
    }

    /**
     * @dev Retorna o nome do Emissor.
     */
    function nomeEmissor() external view returns (string memory) {
        return _emitente;
    }

    /**
     * @dev Retorna a data da emissao.
     */
    function dataEmissao() external view returns (uint256) {
        return _dataEmissao;
    }

    /**
    * @dev muda o prazo de pagamento
    * @notice dependendo da situacao economica o prazo de pagamento pode mudar
    * @param prazoPagamento_ novo prazo de pagamentos a ser adicionado. Em segundos
    */
    function mudaDataPagamento(uint256 prazoPagamento_) external onlyOwner returns (uint256) {
        emit NovoPrazoPagamento(_prazoPagamento, _prazoPagamento + prazoPagamento_);
        _prazoPagamento = _prazoPagamento + prazoPagamento_;
        return _prazoPagamento;
    }

 }