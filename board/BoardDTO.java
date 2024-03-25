package board;

public class BoardDTO {
	/*
	 * TABLE announcement ( 
	 * noticeid INT NOT NULL AUTO_INCREMENT,
	 *  title VARCHAR(255)NOT NULL, 
	 * content TEXT NOT NULL, 
	 * category ENUM('업무', '인사','이벤트'),
	 * authorid VARCHAR(20) NOT NULL, 
	 * publishdate DATETIME NOT NULL, 
	 * img LONGBLOB,
	 */
	
	private int noticeid; // 게시글 번호
	private String title; // 게시글 제목
	private String content; // 게시글 내용
	private String category; // 게시 카테고리
	private String authorid; // 작성자 (DB : 사원코드, FRONT : '관리자')
	private String publishdate; // 작성일시 '0000-00-00 00:00:00' 형태
	private String img; // 이미지
	
	
	public int getNoticeid() {
		return noticeid;
	}
	public void setNoticeid(int noticeid) {
		this.noticeid = noticeid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getAuthorid() {
		return authorid;
	}
	public void setAuthorid(String authorid) {
		this.authorid = authorid;
	}
	public String getPublishdate() {
		return publishdate;
	}
	public void setPublishdate(String publishdate) {
		this.publishdate = publishdate;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}

	
	

/*사진을 담기 위해 LONGBLOB 컬럼을 사용하려는 것이 맞나요? 그렇다면 해당 사진을 바이너리 형식으로 변환하여 데이터베이스에 저장하는 것이 일반적인 방법입니다. Java에서는 이미지를 바이너리 데이터로 변환하여 데이터베이스에 저장할 수 있습니다.

먼저 이미지를 바이너리 데이터로 읽어들인 후, 이 데이터를 데이터베이스에 저장할 준비를 해야 합니다. 아래는 간단한 예제입니다.

java
Copy code
import java.io.*;
import java.sql.*;

public class ImageToDatabase {
    public static void main(String[] args) {
        String imagePath = "path_to_your_image.jpg"; // 이미지 파일 경로

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database", "username", "password");
             PreparedStatement statement = connection.prepareStatement("INSERT INTO your_table (image_column) VALUES (?)")) {

            File imageFile = new File(imagePath);
            FileInputStream fis = new FileInputStream(imageFile);
            statement.setBinaryStream(1, fis, (int) imageFile.length());
            statement.executeUpdate();

            System.out.println("Image inserted successfully.");

        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }
}
위 코드에서 "your_database", "username", "password", "your_table", "image_column"을 실제 데이터베이스 및 테이블 및 컬럼 이름으로 대체해야 합니다.

데이터베이스에서 이미지를 검색하려면 이진 데이터를 다시 이미지로 변환해야 합니다. 이 과정은 이미지 데이터를 읽어서 화면에 표시하는 방식으로 이루어집니다.*/
	
}
