package swing;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ex1 {
    public static void main(String[] args){
        JFrame frame = new JFrame();
        JPanel panel = new JPanel();
        JPanel btnPanel = new JPanel();
        JLabel label = new JLabel("Button");
        JButton exit = new JButton("Exit");
        JButton click = new JButton("Click me!");
        JTextArea textArea = new JTextArea();

        panel.setLayout(new BorderLayout());

        btnPanel.add(click);
        btnPanel.add(exit);
        panel.add(btnPanel, BorderLayout.WEST);
        panel.add(textArea,BorderLayout.CENTER);
        panel.add(label, BorderLayout.NORTH);

        click.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                label.setText(textArea.getText());
            }
        });

        exit.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });

        frame.add(panel);


        frame.setSize(700,700);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.setTitle("나의 첫 번째 창");
        frame.setResizable(false);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}
