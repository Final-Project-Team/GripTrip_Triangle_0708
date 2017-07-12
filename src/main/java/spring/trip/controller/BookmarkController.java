package spring.trip.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import spring.trip.domain.Book;
import spring.trip.domain.Bookmark;
import spring.trip.domain.Member;
import spring.trip.domain.Story;
import spring.trip.model.service.BookService;
import spring.trip.model.service.BookmarkService;
import spring.trip.model.service.StoryService;

@Controller
public class BookmarkController {
   @Autowired
   private BookmarkService bookmarkService;
   @Autowired
   private BookService bookService;
   @Autowired
   private StoryService storyService;
   
   //북마크 추가 컨트롤러
   @RequestMapping("insertBookmark.do")
   public ModelAndView insertBookmark(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
      System.out.println("insertBookmark Controller..");
      Member member = (Member)session.getAttribute("mvo");
      
      Bookmark bookmark = new Bookmark();
      int book_no = Integer.parseInt(request.getParameter("book_no"));
      int storyNo = Integer.parseInt(request.getParameter("storyNo"));
      String getEmail = bookService.getEmailByBookNo(book_no);
      
      Book book = bookService.getBookByBookNo(book_no);
      Story story = storyService.getStoryByStoryNo(request.getParameter("storyNo"));
      System.out.println(story);
      
      if(storyNo!=0){ //스토리를 북마크 추가했을 때
         bookmark = new Bookmark(book_no, storyNo);
         bookmark.setMember(member);
         storyService.updateBookmark(Integer.toString(story.getStoryNo()));
         story.setBookmark("true");
         System.out.println("스토리 북마크 추가");
         bookmarkService.insertBookmark(bookmark);
         
      }else if(storyNo==0){ //북을 북마크 추가했을 때
         System.out.println(book);
         book.setBookmark("true");
         System.out.println(book.getBookmark());
         bookmark = new Bookmark(book_no, storyNo);
         bookmark.setMember(member);
         bookmarkService.insertBookmark(bookmark);
         
         //return new ModelAndView("JsonView");

/*         if(member.getEmail().equals(getEmail)){//로그인한 계정의 이메일과  북마크한 책의 작성자 이메일이 같다면
            return new ModelAndView("redirect:getMyBookList.do");
         }else{
            if(request.getParameter("from")==null)
               return new ModelAndView("JsonView");
               //return new ModelAndView("redirect:getOtherBookList.do");
            else if(request.getParameter("from").equals("book"))
               return new ModelAndView("JsonView");
               //return new ModelAndView("redirect:select.do?select=book");            
         }   */               
      }      
      //bookmarkService.insertBookmark(bookmark);
/*      System.out.println("insert bookmark에서 보내는 story= "+story);
      //어디로부터 왔는지..
      if(request.getParameter("from").equals("all")){
         return new ModelAndView("JsonView");
         //return new ModelAndView("redirect:getOtherBookList.do");
      }else if(request.getParameter("from").equals("story")){
         return new ModelAndView("redirect:select.do?select=story");
      }
      else if(request.getParameter("from")==null){
         return new ModelAndView("redirect:showStory.do?book_no="+book_no+"&&storyNo="+storyNo);
      }*/
      return new ModelAndView("JsonView");
   }
   //로그인한 계정이 북마크한 목록보기
   @RequestMapping("getBookmarks.do")
   public ModelAndView getBookmarks(HttpServletRequest request, HttpServletResponse response) throws Exception{
      List<Bookmark> list = bookmarkService.getBookmarks(request.getParameter("email"));
      ArrayList<Book> bookList = new ArrayList<Book>();
      ArrayList<Story> storyList = new ArrayList<Story>();
      
      if(list.isEmpty()){//북마크한 게시물이 없을 때
         request.setAttribute("bookList", bookList);
         request.setAttribute("storyList", storyList);
         return new ModelAndView("bookmark/showBookmarkList");
      }
      else{//북마크한 게시물이 있을 때
         for(int i=0; i<list.size(); i++){
            if(list.get(i).getStoryNo()==0){//북마크한 게시물의 storyNo이 0일때 == 북을 북마크했다(북 자체를 북마크 추가했다면 스토리넘에 대한 정보는 없기 때문)
               Book book = bookService.getBookByBookNo(list.get(i).getBookNo());
               bookList.add(book);//북마크한 게시물이 북이기 때문에 북리스트에 북객체 add
               request.setAttribute("bookList", bookList);
            }else{// 북마크한 게시물의 storyNo이 0이 아닐때 == 스토리를 북마크했다(스토리는 북넘버와 스토리넘버 둘다 가지고 있기 때문)
               Story story = storyService.getStoryByStoryNo(Integer.toString(list.get(i).getStoryNo()));
               storyList.add(story);//북마크한 게시물이 스토리기 때문에 스토리 리스트에 스토리 객체 add
               System.out.println("받아온 스토리리스트: "+storyList);
            }
         }
      }
      return new ModelAndView("bookmark/showBookmarkList", "storyList", storyList);
   }
   //마이페이지에 있는 북마크리스트에서 북마크 삭제할 때
   @RequestMapping("deleteBookmark.do")
   public ModelAndView deleteBookmark(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
      Member member = (Member)session.getAttribute("mvo");
      int book_no = Integer.parseInt(request.getParameter("book_no"));
      int storyNo = Integer.parseInt(request.getParameter("storyNo"));
      Bookmark bookmark = new Bookmark();
      
      if(storyNo==0){//북마크한 '북'을 삭제할때 (북은 스토리넘버가 없기때문)
         bookmark = new Bookmark(member, book_no, storyNo);
         bookmarkService.deleteBookmark(bookmark);
         bookService.deleteBookmark(book_no);//true로 북마크가 활성화 되어있던 book 테이블의 bookmark 컬럼을 false로
      }
      else if(storyNo!=0){//북마크한 '스토리'를 삭제할때
         bookmark = new Bookmark(member, book_no, storyNo);
         bookmarkService.deleteBookmark(bookmark);
         storyService.deleteStoryBookmark(request.getParameter("storyNo"));//위 book과 동일한 이유
      }
      return new ModelAndView("redirect:getBookmarks.do?email="+member.getEmail());
   }
   //북리스트 뷰페이지(myBook_List.jsp, allbook_List.jsp)에서 바로 북마크 삭제할때
   @RequestMapping("bookDeleteBookmark.do")
   public ModelAndView bookDeleteBookmark(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
      Member member = (Member)session.getAttribute("mvo");
      int book_no = Integer.parseInt(request.getParameter("book_no"));
      String getEmail = bookService.getEmailByBookNo(book_no);
      
      Bookmark bookmark = new Bookmark(member, book_no, 0);
      bookmarkService.deleteBookmark(bookmark);
   
      return new ModelAndView("JsonView");
/*      if(member.getEmail().equals(getEmail)){//로그인한 계정과 삭제하려는 book 작성자 계정이 같다면
         return new ModelAndView("redirect:getMyBookList.do");
      }
      else{
         if(request.getParameter("from")==null)
            return new ModelAndView("JsonView");
            //return new ModelAndView("redirect:getOtherBookList.do");
         else if(request.getParameter("from").equals("book"))
            return new ModelAndView("JsonView");
            //return new ModelAndView("redirect:select.do?select=book");
      }
      return null;   */
   }
   //storyShow.jsp에서 바로 북마크 삭제할 때
   @RequestMapping("storyDeleteBookmark.do")
   public ModelAndView storyDeleteBookmark(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
      Member member = (Member)session.getAttribute("mvo");
      int book_no = Integer.parseInt(request.getParameter("book_no"));
      int storyNo = Integer.parseInt(request.getParameter("storyNo"));

      Bookmark bookmark = new Bookmark(member, book_no, storyNo);
      bookmarkService.deleteBookmark(bookmark);
      
      return new ModelAndView("JsonView");
/*      if(request.getParameter("from").equals("all")){
         return new ModelAndView("JsonView");
         //return new ModelAndView("redirect:getOtherBookList.do");
      }else if(request.getParameter("from").equals("story")){
         return new ModelAndView("redirect:select.do?select=story");
      }
      else if(request.getParameter("from")==null){
         return new ModelAndView("redirect:showStory.do?book_no="+book_no+"&&storyNo="+storyNo);
      }
      return new ModelAndView("redirect:showStory.do?storyNo="+storyNo+"&&book_no="+book_no);*/
   }
}