// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract hospital {

    struct  medicalInstitution{
        string nome;
        string email;
        uint256 identificador;
        bool funcionando ;
        mapping(address => bool) activeDoctors;
        address[] listDoctor; 
    }
    mapping (address => medicalInstitution)   addressToMedicalInstitution;
    
    function getMedicalInstitution(address  Institution ) public view returns(string memory, string memory, uint256,bool){
        return( addressToMedicalInstitution[Institution].nome,
        addressToMedicalInstitution[Institution].email,
        addressToMedicalInstitution[Institution].identificador,
        addressToMedicalInstitution[Institution].funcionando) ;
    }
    function getMedicalList(address  Institution)public  view returns(address[] memory){
        return addressToMedicalInstitution[Institution].listDoctor;
    }
    function checkDoctor(address Institution,address doctor) public view returns(bool){
        return addressToMedicalInstitution[Institution].activeDoctors[doctor];
    }
    function addDoctor(address doctor) external {
        require(InstitutionIsWorking(msg.sender));
        addressToMedicalInstitution[doctor].listDoctor.push(doctor);
    }
    function removeDoctor(address doctor) public {
        require(InstitutionIsWorking(msg.sender));
        uint256 indexToremove = getIndexListDoctor(doctor);
        uint256 indexLastElement = addressToMedicalInstitution[msg.sender].listDoctor.length -1;
        addressToMedicalInstitution[msg.sender].listDoctor[indexToremove] = addressToMedicalInstitution[msg.sender].listDoctor[indexLastElement];
        addressToMedicalInstitution[msg.sender].listDoctor.pop();
        addressToMedicalInstitution[msg.sender].activeDoctors[doctor]=false;
        
    }
    function getIndexListDoctor(address doctor) internal view  returns(uint256){
        require(InstitutionIsWorking(msg.sender));
        for (uint index = 0; index < addressToMedicalInstitution[msg.sender].listDoctor.length - 1; index++) {
            if(doctor == addressToMedicalInstitution[msg.sender].listDoctor[index]){
                return index;
            }

        }
        require(false);
        return 0;
        
    }
    function InstitutionIsWorking(address istitution) internal view returns (bool) {
        return addressToMedicalInstitution[istitution].funcionando;
    }

}


contract doctorContract{

    struct doctor{
        string name;
        uint NumberIdentifier;
        address[] activeHospital;
    }
    mapping(address => doctor) addressToDoctor;
}

