namespace ETomato.Api.Shared.Tomatoes.Classify;

public sealed class ClassificationResultDto
{
    public double Score { get; set; }
    public string Name { get; set; } = default!;
    public string Description { get; set; } = string.Empty;
    public string Prevention { get; set; } = string.Empty;
}