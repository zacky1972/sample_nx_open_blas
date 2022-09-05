#include <erl_nif.h>
#include <cblas.h>

static ERL_NIF_TERM scopy_nif(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    return argv[2];
}


static ErlNifFunc nif_funcs [] =
{
    {"scopy_nif", 3, scopy_nif}
};

ERL_NIF_INIT(Elixir.SampleNxOpenBlas, nif_funcs, NULL, NULL, NULL, NULL)