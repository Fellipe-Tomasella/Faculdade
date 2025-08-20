/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Aula.DB;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author felli_pvxf7hl
 */
public class CriarConexao {
    public static Connection getConexao() throws SQLException{
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("conectando ao banco");
            return DriverManager.getConnection("jdbc:mysql://localhost:3306/aulaPOO?zeroDateTimeBehavior=CONVERT_TO_NULL","root","123456");
        }catch(ClassNotFoundException e){
            throw new SQLException(e.getMessage());
        }
        }
    
    }
    
