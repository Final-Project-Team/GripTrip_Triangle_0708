package spring.trip.model.service;

import java.util.List;

import spring.trip.domain.Book;

public interface BookService {

	public void insertWriteBook(Book book) throws Exception;
	
	public Book getBookByBookNo(int book_no) throws Exception;
	
	public List<Book> getOtherBookList(String email) throws Exception;
	
	public void updateHit(int book_no) throws Exception;
	
	public void updateBook(Book book) throws Exception;
	
	public void deleteBook(int book_no) throws Exception;
	
	public void deleteFile(String book_picture_url) throws Exception;
	
	public String getNickName(int book_no) throws Exception;
	
	public int maxBookNo() throws Exception;
	
	public List<Book> getMyBookList(String email) throws Exception;
	
	public List<Book> getAllBookList() throws Exception;
	
	public void updateBookmark(int book_no) throws Exception;
	
	public void deleteBookmark(int book_no) throws Exception;
	
	public String getEmailByBookNo(int book_no) throws Exception;
	
	public void deleteBookByEmail(String email) throws Exception;

	public List<Book> searchBook(String keyword) throws Exception;
	
	public List<Book> searchBookByTitle(String keyword) throws Exception;
	
	public List<Book> searchBookByContent(String keyword) throws Exception;
	
	public List<Book> searchBookByLocation(String keyword) throws Exception;
	
	public int getStoryCountOfBook(int book_no) throws Exception;
}
