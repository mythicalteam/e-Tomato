using Bogus;
using ETomato.Api.Shared.Tomatoes.Classify;

namespace ETomato.Api.DataAccess.Tomatoes.Classify;

[RepositoryService]
public partial class Repository
{
    public async Task<OneOf<ClassificationResultDto, ServiceError>> ExecuteAsync(string imageString, CancellationToken ct)
    {
        var analysis = GetDummyData().OrderByDescending(d => d.Score).Take(1).First();
        return await Task.FromResult(analysis);
    }

    private List<ClassificationResultDto> GetDummyData()
    {
        var faker = new Faker();

        return
        [
            new()
            {
                Score = faker.Random.Double(0.10, 0.95),
                Name = "Early Blight",
                Description = "Early blight is characterized by dark concentric rings on leaves, leading to yellowing and wilting. It affects lower leaves first and spreads upward.",
                Prevention = "Rotate crops yearly, prune infected leaves, mulch to prevent soil splash, and apply fungicides preventively."
            },
            new()
            {
                Score = faker.Random.Double(0.10, 0.95),
                Name = "Late Blight",
                Description = "Late blight causes dark, water-soaked lesions on leaves and stems, leading to rapid yellowing, browning, and plant death.",
                Prevention = "Ensure good air circulation, avoid overhead watering, remove infected plants, and use copper-based fungicides preventively."
            },
            new()
            {
                Score = faker.Random.Double(0.10, 0.95),
                Name = "Fusarium Wilt",
                Description = "This soil-borne fungus causes wilting, yellowing, and stunting of plants. Leaves turn yellow and eventually brown, leading to plant death.",
                Prevention = "Plant resistant varieties, rotate crops, avoid overwatering, and ensure proper drainage."
            },
            new()
            {
                Score = faker.Random.Double(0.10, 0.95),
                Name = "Verticillium Wilt",
                Description = "Verticillium wilt leads to wilting, yellowing, and browning of leaves. The plant's vascular system is affected, causing stunted growth and reduced yield.",
                Prevention = "Plant resistant varieties, maintain soil pH, practice crop rotation, and remove infected plants."
            },
            new()
            {
                Score = faker.Random.Double(0.10, 0.95),
                Name = "Blossom End Rot",
                Description = "Blossom end rot is a physiological disorder causing dark, sunken lesions at the bottom of tomatoes due to calcium deficiency or irregular watering.",
                Prevention = "Maintain consistent soil moisture, ensure adequate calcium uptake through balanced fertilization, and avoid excessive use of nitrogen."
            },
        ];
    }
}