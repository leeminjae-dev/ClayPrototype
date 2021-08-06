package swing;

import javax.swing.*;
import java.awt.*;



class MyFrame2 extends JFrame {
    Container c = getContentPane();
    JPanel jPanel = new JPanel();
    JButton btn = new JButton();
    JButton buttonList[] = new JButton[4];
    String strList[] = {"확인", "취소", "뒤로가기","앞으로 가기"};

    MyFrame2(){
        setTitle("나의 두번째 창");
        setSize(300,400);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setButton();
        setVisible(true);
    }
    void setButton(){

        jPanel.setBackground(Color.magenta);
        jPanel.setLayout(new FlowLayout());

        for(int i = 0; i<4; i++){
            buttonList[i] = new JButton(strList[i]);
            jPanel.add(buttonList[i]);
        }
        c.add(jPanel);

    }

}

public class MyFrame3 {

    public static void main(String[] args){
        new MyFrame2();
    }
}