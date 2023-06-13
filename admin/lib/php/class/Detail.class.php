<?php
class Detail extends Hydrate {
    private $_db;
    private $data = array();
    private $result;

    public function __construct($cnx){
        $this->_db = $cnx;
        var_dump($cnx);
    }


    public function addDetail($quantite, $id_commande, $id_produit){
        try {
            $query = "INSERT INTO detail(quantite, id_commande, id_produit) VALUES ( :quantite, :id_commande, :id_produit)";
            $res = $this->_db->prepare($query);
            $res->bindValue(':quantite', $quantite);
            $res->bindValue(':id_commande', $id_commande);
            $res->bindValue(':id_produit', $id_produit);

            $res->execute();
            $data = $res->fetch();
            if(!empty($data)){
                return $data;
            }
            else{
                return null;
            }
        }catch (PDOException $e){
            print "échec : ".$e->getMessage();
        }
    }


    public function removeDetail($id_detail){
        try {
            $query = "DELETE FROM detail WHERE id_detail = :id_detail";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id_detail', $id_detail);
            $res->execute();
            $data = $res->fetch();
            if(!empty($data)){
                return $data;
            }
            else{
                return null;
            }
        }catch (PDOException $e){
            print "échec : ".$e->getMessage();
        }
    }

    public function removeAllDetailsOrder($id_commande){
        try{
            $query = "DELETE FROM detail WHERE id_commande = :id_commande";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id_commande', $id_commande);
            $res->execute();
            $data = $res->fetch();
            if(!empty($data)){
                return 1;
            }
            else{
                return 0;
            }
        }catch (PDOException $e){
            print "échec : ".$e->getMessage();
        }

    }

}
