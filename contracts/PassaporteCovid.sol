// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.5.16;

contract passaporteCovid {
    
    //pessoas que receberam a primeira dose
     uint32 public totalPrimeiraDose;
     
     //pessoas que receberam a segunda dose
     uint32 public totalSegundaDose;

     address private administrador;

     struct Cidadao {
         address cidadao;
         uint primeiraDose;
         uint segundaDose;
         bool cadastrado;
     }
     
     mapping(address => Cidadao) listaCidadao;

     constructor() public {
         administrador = msg.sender;
     }

     modifier podeCadastrar() {
         require(msg.sender == administrador,"Voce nao pode cadastrar um cidadao.");
         _;
     }
     
     modifier podeAplicarPrimeiraDose() {
         require(listaCidadao[msg.sender].primeiraDose == uint(0),"Cidadao ja recebeu a primeira dose.");
         require(listaCidadao[msg.sender].cadastrado == bool(true), "Cidadao nao cadastrado.");
         _;
     }
     
     modifier podeAplicarSegundaDose() {
         require(listaCidadao[msg.sender].segundaDose == uint(0),"Cidadao ja recebeu a segunda dose.");
         require(listaCidadao[msg.sender].primeiraDose != uint(0), "Cidadao ainda nao recebeu a primeira dose.");
         _;
     }

     function cadastrarCidadao(address cidadao) external podeCadastrar(){
         listaCidadao[cidadao].cadastrado = true;
     }
     
     function timestampPrimeiraDose() external view returns (uint) {
         return listaCidadao[msg.sender].primeiraDose;
     }
     
     function timestampSegundaDose() external view returns (uint) {
         return listaCidadao[msg.sender].segundaDose;
     }
     
     function aplicarPrimeiraDose(uint timestamp) external podeAplicarPrimeiraDose() {
         listaCidadao[msg.sender].primeiraDose = timestamp;
         totalPrimeiraDose += 1;
     }
     
     function aplicarSegundaDose(uint timestamp) external podeAplicarSegundaDose() {
         listaCidadao[msg.sender].segundaDose = timestamp;
         totalSegundaDose += 1;
     }
     
     
}