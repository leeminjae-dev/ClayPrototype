package swing;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class LogIn extends JFrame {
    public LogIn(){
        JPanel panel = new JPanel();
        JLabel label = new JLabel("ID : ");
        JLabel psword = new JLabel("Password : ");
        JTextField txtID = new JTextField(10);
        JPasswordField txtPass = new JPasswordField(10);
        JButton loginBtn = new JButton("로그인");

        panel.add(label);
        panel.add(txtID);
        panel.add(psword);
        panel.add(txtPass);
        panel.add(loginBtn);

        loginBtn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String id = "LMJ";
                String pass = "1234";

                if(id.equals(txtID.getText()) && pass.equals(txtPass.getText())){
                    JOptionPane.showMessageDialog(null,"로그인에 성공하였습니다.","로그인 성공",JOptionPane.INFORMATION_MESSAGE);
                }
                else{
                    JOptionPane.showMessageDialog(null,"로그인에 실패하였습니다.","오류",JOptionPane.ERROR_MESSAGE);
                }
            }
        });
        add(panel);

        setVisible(true);
        setTitle("LogIn");
        setResizable(false);
        setSize(600, 400);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }
    public static void main(String[] args){
        new LogIn();
    }
}
