import tensorflow as tf
import numpy as np
import scipy

n = 10
t = np.array(range(1, 30), np.float64) / 29
T = tf.constant(np.transpose(np.repeat([t], n, axis=0)))
j = tf.constant(np.array(range(n)), tf.float64)

def Waston():
    x = tf.Variable(np.zeros(n), tf.float64)
    r = tf.reduce_sum((j * (T ** (j - 1)) * x[0:29], 1) - \
        tf.redure_sum(((T ** j) * x[0:29]) ** 2 - 1) ** 2, 1) - 1
#    print ((j * (T ** (j - 1)) * x[0:29] - ((T ** j) * x[0:29]) ** 2 - 1) ** 2).shape
    print r.shape
    f = tf.reduce_sum((r ** 2)
    f += x[0] ** 2 + (x[1] - x[0] ** 2 - 1) ** 2
    return f

if __name__ == '__main__':
    sess = tf.Session()

    f = Waston()
    train_step = tf.train.AdamOptimizer(1e-4).minimize(f)
    sess.run(tf.global_variables_initializer())
    sess.run(train_step, feed_dict={})
    print f.eval(session=sess, feed_dict={})
