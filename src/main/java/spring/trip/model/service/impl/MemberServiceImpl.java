package spring.trip.model.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.trip.domain.Member;
import spring.trip.model.dao.MemberDAO;
import spring.trip.model.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService{
	
	// field
	@Autowired
	private MemberDAO memberDAO;

	@Override
	public boolean isEmailExist(String email) {
		return memberDAO.isEmailExist(email);
	}

	@Override
	public boolean isNicknameExist(String nickname) {
		return memberDAO.isNicknameExist(nickname);
	}

	@Override
	public int registerMember(Member vo) {
		return memberDAO.registerMember(vo);
	}

	@Override
	public boolean checkPassword(Member vo) {
		return memberDAO.checkPassword(vo);
	}

	@Override
	public int removeMember(String email) {
		int row= memberDAO.removeMember(email);
		return row;
	}

	@Override
	public Member login(Member vo) {
		Member rvo = memberDAO.login(vo);
		return rvo;
	}

	@Override
	public Member showMemberInfo(String email) {
		Member vo = memberDAO.showMemberInfo(email);
		return vo;
	}

	@Override
	public int updateMember(Member vo) {
		int row= memberDAO.updateMember(vo);
		return row;
	}
}
