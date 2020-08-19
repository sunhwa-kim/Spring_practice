package kr.go.cris.commons.ws;

import java.util.Map;

import kr.go.cris.commons.login.vo.UserVo;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request,
			ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		UserVo user = (UserVo) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		attributes.put(user.getEmplyrkey(),user.getEmplyrkey());
		return super.beforeHandshake(request, response, wsHandler, attributes);
	}
}
