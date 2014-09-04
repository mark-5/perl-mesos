#ifndef NET_MESOS_UTILS_
#define NET_MESOS_UTILS_

#include <vector>
#include <string>
#include <MesosChannel.hpp>

template<typename T>
const T toMsg(const std::string str)
{
    T msg;
    msg.ParseFromString(str);
    return msg;
}

template<typename T>
const std::vector<T> toMsg(const std::vector<std::string> strs)
{
    std::vector<T> rvec;
    for (std::vector<std::string>::const_iterator it = strs.begin(); it != strs.end(); ++it) {
        const std::string str(*it);
        rvec.push_back( toMsg<T>(str) );
    }
    return rvec;
}

const std::string sv_to_msg(SV* msg) {
    dSP;
    ENTER;
    SAVETMPS;
    PUSHMARK(SP);
    XPUSHs(msg);
    PUTBACK;
    int rc = call_method("encode", G_SCALAR);
    SPAGAIN;

    std::string retval(POPp);

    FREETMPS;
    LEAVE;

    return retval; 
}

std::string sv_to_string(SV* sv) {
    return std::string( SvPV_nolen(sv), SvCUR(sv) );
}

SV* string_to_sv(const std::string str) {
    return newSVpvn(str.c_str(), str.length());
}

std::string av_type(AV* av) {
    SV* first = *(av_fetch(av, 0, 0));
    if (SvROK(first) && sv_isobject(first)) {
        return std::string(sv_reftype(SvRV(first), 1));
    } else {
        return std::string("String");
    }
}

mesos::perl::CommandArg sv_to_CommandArg(SV* msg) {
    if (SvTYPE(msg) == SVt_PV) {
        return mesos::perl::CommandArg(sv_to_string(msg));
    } else if (!SvROK(msg)) {
        Perl_croak(aTHX_ "Must pass string or ref as command arg");
    } else if (sv_isobject(msg)) {
        const char* type = sv_reftype(SvRV(msg), 1);
        return mesos::perl::CommandArg(sv_to_msg(msg), std::string(type));
    } else if (SvTYPE(SvRV(msg)) == SVt_PVAV) {
        AV* args_av = (AV*) SvRV(msg);
        int length = AvFILL(args_av) + 1;
        std::vector<std::string> data_vec;
        for (int i = 0; i < length; i++) {
            SV* el = *(av_fetch(args_av, i, 0));
            std::string data = sv_isobject(el) ? sv_to_msg(el) : sv_to_string(el);
            data_vec.push_back(data);
        }
        return mesos::perl::CommandArg(data_vec, av_type(args_av));
    }
}

SV* CommandArg_to_sv(const mesos::perl::CommandArg arg) {
    AV* return_av = newAV();
    if (arg.context_ == mesos::perl::context::SCALAR) {
        av_store(return_av, 0, string_to_sv(arg.scalar_data_));
    } else if(arg.context_ == mesos::perl::context::ARRAY) {
        AV* arg_av = newAV();
        std::vector<std::string> data_vec = arg.array_data_;
        for (int i = 0; i < data_vec.size(); i++) {
            av_store(arg_av, i, string_to_sv(data_vec.at(i)));
        }
        av_store(return_av, 0, newRV_noinc((SV*) arg_av));
    }
    av_store(return_av, 1, string_to_sv(arg.type_));
    return newRV_noinc((SV*) return_av);
}

#endif // NET_MESOS_UTILS_
