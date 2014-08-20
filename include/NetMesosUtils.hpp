#ifndef NET_MESOS_UTILS_
#define NET_MESOS_UTILS_

#include <vector>
#include <string>

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

template<typename T>
const std::vector<T> fillVec(int count, const T el, ...) {
    std::vector<T> rvec(count);
    va_list ap;
    va_start(ap, el);
    for (int i = 0; i < count; i++) {
        rvec.at(i) = va_arg(ap, T);
    }
    va_end(ap);
    return rvec;
}

#endif // NET_MESOS_UTILS_
