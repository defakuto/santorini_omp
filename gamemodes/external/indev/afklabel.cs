public class MyDynamicTextLabel : BaseMode
{
    private TextLabel _dynamicLabel;
    private bool _isAfk;

    protected override void OnInitialized(EventArgs e)
    {
        _dynamicLabel = new TextLabel("Dynamic Label", Color.White, new Vector3(100.0f, 100.0f, 10.0f), 100.0f);
        
        _isAfk = false;
        
        GameMode.OnUpdate += CheckPlayerActivity;
    }
/*

    private void CheckPlayerActivity(int sender, OnUpdateEventArgs e)
    {

    }

    protected override void Dispose(bool disposing)
    {

    }
*/
}