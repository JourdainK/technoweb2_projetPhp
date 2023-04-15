<?php

class produits extends Hydrate {
    private $_db; //recevra $cnx de l'index
    private $_array = array(); //retourner le result set

    public function __construct($cnx){
        $this->_db = $cnx;
        var_dump($cnx);
    }

    public function getAllProduits(){
        try{
            $query = "SELECT * FROM produit ORDER BY id_produit";
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
        catch(PDOException $e){
            echo '<br>Echec de la connection : '.$e->getMessage();
        }
    }

    public function updateProduit($champ,$valeur,$id_produit){
        try {
            $query = "update produit set ".$champ." = :valeur WHERE id_produit= :id_produit";
            $res = $this->_db->prepare($query);
            $res->bindValue('=valeur',$valeur);
            $res->bindValue(':id_produit',$id_produit);
            $res->execute();
        }catch (PDOException $e){
            print 'Echec'.$e->getMessage();
        }
    }

    //Spécial ajax
    public function getProdById($id){
        try{
            $query="select * from produit where id_produit = :id";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id',$id);
            $res->execute();
            $data = $res->fetch();
            return $data;
        }catch(PDOException $e){
            print "Echec ".$e->getMessage();
        }
    }

    public function deleteProd($id_produit){
        try{
            $query = "DELETE FROM produit where id_produit= :id_produit";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id_produit',$id_produit);
            $res->execute();

        }catch(PDOException $e) {
            print "Echec ".$e->getMessage();
        }
    }

}
