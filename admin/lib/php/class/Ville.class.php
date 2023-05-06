<?php

class Ville extends Hydrate {

    private $_db;
    private $data = array();
    private $result;

    public function __construct($cnx){
        $this->_db = $cnx;
    }

    public function getAllVille(){
        try{
            $query = "SELECT * FROM ville ORDER BY id_ville";
            $result = $this->_db->prepare($query);
            $result->execute();

            while($data = $result->fetch()){
                $_array[] = new Hydrate($data);
            }
            if(empty($_array)){
                return null;
            }
            else{
                return $_array;
            }
        }catch (PDOException $e){
            print 'Erreur lors de la récupération des villes : '.$e->getMessage();
        }
    }

    public function getVilleID($nom){
        try{
            $query = "SELECT id_ville FROM ville WHERE nom_ville=:nom";
            $result = $this->_db->prepare($query);
            $result->bindValue(':nom', $nom); // use $nom->nom_ville instead of $nom
            $result->execute();
            $data = $result->fetch(PDO::FETCH_OBJ);
            return $data;

        }catch (PDOException $e){
            print "Erreur lors de la récupération du numéro d'identification de la ville : ".$e->getMessage();
        }
    }



    //Using function in pgsql _> addville(nomville TEXT, nompays TEXT, codep INTEGER)
    public function addVille($nom,$pays,$codep){
        try{
            $query = "SELECT addville(:nomville,:nompays,:codep) as retour";
            $result = $this->_db->prepare($query);
            $result->bindValue(":nomville",$nom);
            $result->bindValue(":nompays",$pays);
            $result->bindValue(":codep",$codep);
            $result->execute();
            //TODO check if this works

            $retour = $this->_db->lastInsertId();
            return $retour;
        }catch (PDOException $e){
            print "Erreur lors de l'ajout de la ville : ".$e->getMessage();
        }
    }



}
