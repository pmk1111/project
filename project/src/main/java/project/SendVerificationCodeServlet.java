package project;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SendVerificationCodeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String recipientEmail = request.getParameter("email"); // 입력된 이메일 주소

        // 난수(인증번호) 생성
        Random random = new Random();
        int verificationCode = 100000 + random.nextInt(900000); // 6자리 난수 생성

        // 이메일로 인증번호 전송
        String senderEmail = "wndudajt@naver.com"; // 여러분의 이메일 주소
        String senderPassword = "rlawndud1234!"; // 여러분의 이메일 비밀번호

        String subject = "이메일 인증 번호";
        String body = "인증 번호는 다음과 같습니다: " + verificationCode;

        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", "smtp.naver.com"); //  SMTP 호스트
            properties.put("mail.smtp.port", "587"); //  SMTP 포트

            Session session = Session.getInstance(properties, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);

            // 인증번호를 클라이언트에게 전송
            response.getWriter().write(Integer.toString(verificationCode));
        } catch (MessagingException e) {
            e.printStackTrace();
            
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	String recipientEmail = req.getParameter("email"); // 입력된 이메일 주소

        // 난수(인증번호) 생성
        Random random = new Random();
        int verificationCode = 100000 + random.nextInt(900000); // 6자리 난수 생성

        // 이메일로 인증번호 전송
        String senderEmail = "wndudajt@naver.com"; // 여러분의 이메일 주소
        String senderPassword = "rlawndud1234!"; // 여러분의 이메일 비밀번호

        String subject = "이메일 인증 번호";
        String body = "인증 번호는 다음과 같습니다: " + verificationCode;

        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.host", "smtp.naver.com"); //  SMTP 호스트
            properties.put("mail.smtp.port", "587"); //  SMTP 포트

            Session session = Session.getInstance(properties, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);

            // 인증번호를 클라이언트에게 전송
            ((ServletResponse) req).getWriter().write(Integer.toString(verificationCode));
        } catch (MessagingException e) {
            e.printStackTrace();
            
        }
    	
    }
}
