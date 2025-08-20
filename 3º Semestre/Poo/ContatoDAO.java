/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Aula.Dao;


import Aula.DB.CriarConexao;
import Aula.Logica.Contato;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContatoDAO {
    private Connection conexao;
    
    public ContatoDAO() throws SQLException{
        this.conexao = CriarConexao.getConexao();
    }
    public void adicionarContato(Contato c1) throws SQLException{
        String sql = "insert into contato(Nome, Telefone) values(?,?)";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setString(1, c1.getNome());
        stmt.setString(2, c1.getTelefone());
        stmt.execute();
        stmt.close();
    }
    public List<Contato> getListContato() throws SQLException{
        String sql = "selec * from contato";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        List<Contato> minhalista = new ArrayList<Contato>();
        while(rs.next()){
            Contato c1 = new Contato();
            c1.setId(rs.getInt("id"));
            c1.setNome(rs.getString("nome"));
            c1.setTelefone(rs.getString("telefone"));
            minhalista.add(c1);
        }
    rs.close();
    stmt.close();
    return minhalista;    
    }
    public void alterarContato(Contato c1) throws SQLException{
        String sql = "update contato set nome=?, telefone=? where id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setString(1, c1.getNome());
        stmt.setString(2, c1.getTelefone());
        stmt.setInt(3, c1.getId());
        stmt.execute();
        stmt.close();
    }
    public void removerContato(Contato c1) throws SQLException{
        String sql = "delete from contato where id=?";
        PreparedStatement stmt = conexao.prepareStatement(sql);
        stmt.setInt(1, c1.getId());
        stmt.execute();
        stmt.close();
        
    }
}

