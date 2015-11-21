package br.com.system.websys.entities;

public enum Role{

	ROLE_ADMIN("ROLE_ADMIN"),
	ROLE_MARINHEIRO("ROLE_MARINHEIRO"),
	ROLE_COTISTA("ROLE_COTISTA");
	
	private String role;

	private Role(String role){
		this.role = role;
	}
	
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}
	
	
}