/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package com.mycompany.mavenproject3;

import Aula.DB.CriarConexao;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author felli_pvxf7hl
 */
public class Mavenproject3 {
    public static void main(String[] args) throws SQLException{
        Connection conexao = CriarConexao.getConexao();
        conexao.close();
        System.out.println("Desconectado do banco");
    }
    }