package br.com.system.websys.entities;

public enum Role{

	ROLE_ROOT("ROLE_ROOT", "Root"),
	ROLE_ADMIN("ROLE_ADMIN", "Admin"),
	ROLE_MARINHEIRO("ROLE_MARINHEIRO", "Marinheiro"),
	ROLE_COTISTA("ROLE_COTISTA", "Cotista");
	
	private String role;
	private String code;
	
	private Role(String code, String role){
		this.role = role;
		this.code = code;
	}
	
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	
}