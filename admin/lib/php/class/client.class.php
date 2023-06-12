<?php

class client extends Hydrate {

    private $_db;
    private $data = array();
    private $result;

    public function __construct($cnx){
        $this->_db = $cnx;
        var_dump($cnx);
    }

    //TODO md5 -> protect password

    public function isClient($mail,$pwd){
        try{
            $query = "SELECT * FROM client WHERE email_client = :mail AND password = :pwd";
            $res = $this->_db->prepare($query);
            $res->bindValue(':mail',$mail);
            $res->bindValue(':pwd',$pwd);
            $res->execute();
            $data = $res->fetch();
            if(!empty($data)){
                return true;
            }
            else{
                return false;
            }
        }catch (PDOException $e){
            print "échec : ".$e->getMessage();
        }
    }

    public function getClientByMail($mail){
        try{
            $query = "SELECT * FROM client WHERE email_client = :mail";
            $res = $this->_db->prepare($query);
            $res->bindValue(':mail',$mail);
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

    public function addClient($nom_client, $pass, $email_cli, $id_ville){
        try {
            $query = "INSERT INTO client(nom_client, password, email_client, id_ville) VALUES (:nom_client, :pass, :email_cli, :id_ville)";
            $res = $this->_db->prepare($query);
            $res->bindValue(':nom_client', $nom_client);
            $res->bindValue(':pass', $pass);
            $res->bindValue(':email_cli', $email_cli);
            $res->bindValue(':id_ville', $id_ville, PDO::PARAM_INT);
            $res->execute();
            $check = $this->_db->lastInsertId();
            return $check;
        } catch (PDOException $e) {
            print "Erreur lors de l'ajout client : " . $e->getMessage();
        }
    }



    public function deleteClient($id){
        try{
            $query = "DELETE FROM client WHERE id_client = :id";
            $res = $this->_db->prepare($query);
            $res->bindValue(':id',$id);
            $res->execute();

        }catch (PDOException $e){
            print "Échec lors de l'effacement du client : ".$e->getMessage();
        }
    }

    //https://www.postgresqltutorial.com/postgresql-plpgsql/plpgsql-if-else-statements/
    //https://dba.stackexchange.com/questions/10492/is-there-a-simple-way-in-pl-pgsql-to-check-if-a-query-returned-no-result
    // + chatGpt
    //use of Function plsql -> updateclient
    public function updateClient($id,$nom,$pass,$email,$idville){
        try{
            $query = "SELECT updateclient(:id,:nom,:pass,:mail,:idville) AS check";
            $result = $this->_db->prepare($query);
            $result->binValue(":id",$id);
            $result->binValue(":nom",$nom);
            $result->binValue(":pass",$pass);
            $result->binValue(":mail",$email);
            $result->binValue(":idville",$idville);
            $result->execute();
            $check = $result->fetch(PDO::FETCH_ASSOC)["check"];

            return $check;

        }catch (PDOException $e){
            print "Erreur lors de la mise à jour du client : ".$e->getMessage();
            return false;
        }
    }


    public function getAllClient(){
        try{
            $query = "SELECT * FROM client ORDER BY id_client";
            $result = $this->_db->prepare($query);
            $result->execute();

            while($data = $result->fetch()){
                $_array[]=new Hydrate($data);
            }
            if(empty($_array)){
                return null;
            }
            else{
                return $_array;
            }
        }catch (PDOException $e){
            echo '<br>Erreur lors de la récupération des clients :'.$e->getMessage();
        }
    }


}