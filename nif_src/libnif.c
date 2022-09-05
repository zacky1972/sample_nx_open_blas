#include <erl_nif.h>
#include <cblas.h>

static ERL_NIF_TERM scopy_nif(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_atom(env, "ok");
}


static ErlNifFunc nif_funcs [] =
{
    {"scopy_nif", 1, scopy_nif}
};

ERL_NIF_INIT(Elixir.SampleNxOpenBlas, nif_funcs, NULL, NULL, NULL, NULL)