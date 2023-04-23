<?php

class Categorie extends Hydrate {
    private $_db;
    private $_array;

    public function __construct($cnx){
        $this->_db = $cnx;
        var_dump($cnx);
    }

    public function getAllCategories(){
        try{
            $query = "SELECT * FROM categorie ORDER BY id_categorie";
            $res = $this->_db->prepare($query);
            $res->execute();
            while($data = $res->fetch()){
                $_array[]=new Hydrate($data);
            }
            if(empty($_array)){
                return null;
            }
            else{
                return $_array;
            }
        }
        catch (PDOException $e){
            echo '<br>Echec de la connexion : '.$e->getMessage();
        }
    }



}