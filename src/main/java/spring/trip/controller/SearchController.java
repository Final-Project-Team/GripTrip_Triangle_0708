package spring.trip.controller;

import java.net.URLDecoder;
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
import spring.trip.model.service.ReportService;
import spring.trip.model.service.StoryService;

@Controller
public class SearchController {
   @Autowired
   private BookService bookService;

   @Autowired
   private StoryService storyService;

   @Autowired
   private BookmarkService bookmarkService;

   @Autowired
   private ReportService reportService;

   @RequestMapping("search.do")
   public ModelAndView search(HttpServletRequest request, HttpServletResponse response, HttpSession session)
         throws Exception {
      response.setContentType("text/html;charset=utf-8");
      Member member = (Member) session.getAttribute("mvo");
      String keyword = request.getParameter("keyword");
      String select = request.getParameter("select");
      keyword = URLDecoder.decode(keyword, "utf-8");
      System.out.println(keyword);
      List<Book> bookList = null;
      List<Story> storyList = null;
      ArrayList<Book> allBookList = new ArrayList<Book>();
      ArrayList<Story> allStoryList = new ArrayList<Story>();
      List<String> reportList = reportService.selectReport();
      
      //키워드 trim
      String[] rkeyword = keyword.split(" ");

      for(String s : rkeyword){
      if (request.getParameter("from").equals("all")) {
         if (select.equals("all")) {
            bookList = bookService.searchBook(s);
            storyList = storyService.searchStory(s);
         } else if (select.equals("title")) {
            bookList = bookService.searchBookByTitle(s);
            storyList = storyService.searchStoryByTitle(s);
         } else if (select.equals("content")) {
            bookList = bookService.searchBookByContent(s);
            storyList = storyService.searchStoryByContent(s);
         } else if (select.equals("location")) {
            bookList = bookService.searchBookByLocation(s);
            storyList = storyService.searchStoryByLocation(s);
         }
         // 북 북마크 설정, 닉네임 설정
         // 로그인 되어있을 때
         if (member != null) {
            List<Bookmark> bookmarkList = bookmarkService.myBookmark(member.getEmail());
            for (int i = 0; i < bookList.size(); i++) {
               bookList.get(i).setBookmark("false");
               String nick = bookService.getNickName(bookList.get(i).getBook_no());
               bookList.get(i).setNick(nick);
               for (int j = 0; j < bookmarkList.size(); j++) {
                  if (bookmarkList.get(j).getBookNo() == bookList.get(i).getBook_no()
                        && bookmarkList.get(j).getStoryNo() == 0) {
                     bookService.updateBookmark(bookList.get(i).getBook_no());
                     bookList.get(i).setBookmark("true");
                     System.out.println(bookList.get(i).getBookmark());
                  }
               }
            }
            // 스토리 북마크, 닉네임 설정
            bookmarkList = bookmarkService.myBookmark(member.getEmail());
            for (int i = 0; i < storyList.size(); i++) {
               storyList.get(i).setBookmark("false");
               String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
               storyList.get(i).getMember().setNickname(nick);
               for (int j = 0; j < bookmarkList.size(); j++) {
                  if (bookmarkList.get(j).getBookNo() == storyList.get(i).getBook().getBook_no()
                        && bookmarkList.get(j).getStoryNo() == storyList.get(i).getStoryNo()) {
                     storyService.updateBookmark(Integer.toString(storyList.get(i).getStoryNo()));
                     storyList.get(i).setBookmark("true");
                  }
               } // for bookmarkList
            } // for storyList
         } else {
            for (int i = 0; i < bookList.size(); i++) {
               String nick = bookService.getNickName(bookList.get(i).getBook_no());
               bookList.get(i).setNick(nick);
            }
            for (int i = 0; i < storyList.size(); i++) {
               String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
               storyList.get(i).getMember().setNickname(nick);
               }
            } // member가 null일 때
         } // from all일 때
          allBookList.addAll(bookList);
          allStoryList.addAll(storyList);
      } // keyword갯수만큼 for
      request.setAttribute("keyword", keyword);
      request.setAttribute("select", select);
      request.setAttribute("reportList", reportList);
      request.setAttribute("storyList", allStoryList);
      return new ModelAndView("book/allList", "bookList", allBookList);
   }// method

   @RequestMapping("searchAgain.do")
   public ModelAndView searchAgain(HttpServletRequest request, HttpServletResponse response, HttpSession session)
         throws Exception {
      response.setContentType("text/html;charset=utf-8");
      Member member = (Member) session.getAttribute("mvo");
      String keyword = request.getParameter("keyword");
      String select = request.getParameter("select");
      keyword = URLDecoder.decode(keyword);
      List<Book> bookList = null;
      List<Story> storyList = null;
      ArrayList<Book> allBookList = new ArrayList<Book>();
      ArrayList<Story> allStoryList = new ArrayList<Story>();
      List<String> reportList = reportService.selectReport();
      int caseId = 0;
      
      System.out.println(select);
      String[] rkeyword = keyword.split(" ");
      
      for(String s: rkeyword){
      if (request.getParameter("from").equals("all")) {
         if (member == null){
            return new ModelAndView("redirect:getAllList.do");
         }
         else{            
            return new ModelAndView("redirect:getOtherBookList.do");
         }
      } // from all일 때
      else if (request.getParameter("from").equals("book")) {
         if (select.equals("all")) {
            bookList = bookService.searchBook(s);
         } else if (select.equals("title")) {
            bookList = bookService.searchBookByTitle(s);
         } else if (select.equals("content")) {
            bookList = bookService.searchBookByContent(s);
         } else if (select.equals("location")) {
            bookList = bookService.searchBookByLocation(s);
         } else {
            if (member == null) {
               bookList = bookService.getAllBookList();
               for (int i = 0; i < bookList.size(); i++) {
                  String nick = bookService.getNickName(bookList.get(i).getBook_no());
                  bookList.get(i).setNick(nick);
               } // for
               caseId=1;
            } else {
               bookList = bookService.getOtherBookList(member.getEmail());
               List<Bookmark> bookmarkList = bookmarkService.myBookmark(member.getEmail());
               for (int i = 0; i < bookList.size(); i++) {
                  bookList.get(i).setBookmark("false");
                  String nick = bookService.getNickName(bookList.get(i).getBook_no());
                  bookList.get(i).setNick(nick);
                  for (int j = 0; j < bookmarkList.size(); j++) {
                     System.out.println("스토리넘만 " + bookmarkList.get(j));
                     if (bookmarkList.get(j).getBookNo() == bookList.get(i).getBook_no()
                           && bookmarkList.get(j).getStoryNo() == 0) {
                        bookService.updateBookmark(bookList.get(i).getBook_no());
                        bookList.get(i).setBookmark("true");
                        System.out.println(bookList.get(i).getBookmark());
                     } // if
                  } // for
               } // for
               caseId=2;
            } // else
         }
         // 닉네임 먹이기
         for (int i = 0; i < bookList.size(); i++) {
            String nick = bookService.getNickName(bookList.get(i).getBook_no());
            bookList.get(i).setNick(nick);
         }
         // 로그인 유무 확인
         if (member == null) {
            caseId=3;
         } 
         else {
            List<Bookmark> bookmarkList = bookmarkService.myBookmark(member.getEmail());
            for (int i = 0; i < bookList.size(); i++) {
               bookList.get(i).setBookmark("false");
               String nick = bookService.getNickName(bookList.get(i).getBook_no());
               bookList.get(i).setNick(nick);
               for (int j = 0; j < bookmarkList.size(); j++) {
                  if (bookmarkList.get(j).getBookNo() == bookList.get(i).getBook_no()
                        && bookmarkList.get(j).getStoryNo() == 0) {
                     bookService.updateBookmark(bookList.get(i).getBook_no());
                     bookList.get(i).setBookmark("true");
                     System.out.println(bookList.get(i).getBookmark());
                  } // if
               } // for
            } // for
            caseId=4;
         } // else
         System.out.println("from book일 때: "+s);
      } // from book일 때
      else if (request.getParameter("from").equals("story")) {
         if (select.equals("all")) {
            storyList = storyService.searchStory(s);
         } else if (select.equals("title")) {
            storyList = storyService.searchStoryByTitle(s);
         } else if (select.equals("content")) {
            storyList = storyService.searchStoryByContent(s);
         } else if (select.equals("location")) {
            storyList = storyService.searchStoryByLocation(s);
         } else {
            if (member == null) {
               storyList = storyService.allStoryList();
               for (int i = 0; i < storyList.size(); i++) {
                  String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
                  storyList.get(i).getMember().setNickname(nick);
               }
               caseId=5;
            } else {
               storyList = storyService.otherStoryList(member.getEmail());
               List<Bookmark> bookmarkList = bookmarkService.myBookmark(member.getEmail());
               for (int i = 0; i < storyList.size(); i++) {
                  storyList.get(i).setBookmark("false");
                  String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
                  storyList.get(i).getMember().setNickname(nick);
                  for (int j = 0; j < bookmarkList.size(); j++) {
                     if (bookmarkList.get(j).getBookNo() == storyList.get(i).getBook().getBook_no()
                           && bookmarkList.get(j).getStoryNo() == storyList.get(i).getStoryNo()) {
                        storyService.updateBookmark(Integer.toString(storyList.get(i).getStoryNo()));
                        storyList.get(i).setBookmark("true");
                     }
                  } // for bookmarkList
               } // for storyList
               caseId=6;
            }
         } // story

         for (int i = 0; i < storyList.size(); i++) {
            String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
            storyList.get(i).getMember().setNickname(nick);
         }
         // 로그인 유무 확인
         if (member == null) {
            caseId=7;
         } else {
            List<Bookmark> bookmarkList = bookmarkService.myBookmark(member.getEmail());
            for (int i = 0; i < storyList.size(); i++) {
               storyList.get(i).setBookmark("false");
               String nick = bookService.getNickName(storyList.get(i).getBook().getBook_no());
               storyList.get(i).getMember().setNickname(nick);
               for (int j = 0; j < bookmarkList.size(); j++) {
                  if (bookmarkList.get(j).getBookNo() == storyList.get(i).getBook().getBook_no()
                        && bookmarkList.get(j).getStoryNo() == storyList.get(i).getStoryNo()) {
                     storyService.updateBookmark(Integer.toString(storyList.get(i).getStoryNo()));
                     storyList.get(i).setBookmark("true");
                  }
               } // for bookmarkList
            } // for storyList
            caseId=8;
            }//member가 null이 아닐 때
         } // from story일 때
         if(bookList!=null)
            allBookList.addAll(bookList);
         if(storyList!=null)
            allStoryList.addAll(storyList);
      }//for
      request.setAttribute("keyword", keyword);
      request.setAttribute("select", select);
      request.setAttribute("reportList", reportList);
      switch (caseId) {
/*      case 3: case 12:
         return new ModelAndView("book/allList", "bookList", allBookList);*/
      case 1: case 2:   case 3: case 4:
         return new ModelAndView("book/bookList", "bookList", allBookList);
      case 5:   case 6:   case 7: case 8:
         return new ModelAndView("story/storyListForSearch", "storyList", allStoryList);
      }
      return null;
   }//method
}