global with sharing class Incident 
{
	public String className { get; set; }
	public String method { get; set; }
	public String relatedObject { get; set; }
	public String message { get; set; }
	public String notes { get; set; }

	public Incident()
	{
		this.className = '';
		this.method = '';
		this.relatedObject = '';
		this.message = '';
		this.notes = '';
	}
}
