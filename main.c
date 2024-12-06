#include <riv.h>

static void setup()
{
}

static void update()
{
}

static void draw()
{
}

int main()
{
    setup();

    do
    {
        update();
        draw();
    }
    while (riv_present());

    return 0;
}
