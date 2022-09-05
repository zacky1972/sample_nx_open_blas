#include <erl_nif.h>
#include <cblas.h>

static ERL_NIF_TERM copy_nif(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
    return enif_make_atom(env, "ok");
}


static ErlNifFunc nif_funcs [] =
{
    {"copy_nif", 1, copy_nif}
};

ERL_NIF_INIT(Elixir.SampleNxOpenBlas, nif_funcs, NULL, NULL, NULL, NULL)