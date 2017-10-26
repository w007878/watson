import tensorflow as tf
import numpy as np
import scipy

n = input("Please input Dim of x ")
t = np.array(range(1, 30), np.float64) / 29.
T = tf.constant(np.transpose(np.repeat([t], n, axis=0)))
j = tf.constant(np.array(range(n)), tf.float64)

print T
print j

def Waston():
    x = tf.Variable(np.zeros(n), tf.float64, name='x')
    r = tf.reduce_sum(j * (T ** (j - 1)) * x[0:29], 1) - \
        tf.reduce_sum((T ** j) * x[0:29], 1) ** 2 - 1
#    print ((j * (T ** (j - 1)) * x[0:29] - ((T ** j) * x[0:29]) ** 2 - 1) ** 2).shape
    print r.shape
    f = tf.reduce_sum((r ** 2))
    f += x[0] ** 2 + (x[1] - x[0] ** 2 - 1) ** 2
    return f, x

if __name__ == '__main__':
    sess = tf.Session()

    fval, xmin = Waston()
    global_step = tf.Variable(0, dtype=tf.int64, trainable=False)

    # train_step = tf.train.GradientDescentOptimizer(0.0001).minimize(fval)
    # train_step = tf.train.AdagradDAOptimizer(0.001, global_step).minimize(fval)
    train_step = tf.train.AdamOptimizer(0.001).minimize(fval)

    sess.run(tf.global_variables_initializer())
    print fval.eval(session=sess, feed_dict={})

    for i in xrange(1000000):
        if i % 5000 == 0:
            print "Epoch {}".format(i)
            print fval.eval(session=sess, feed_dict={})
            print xmin.eval(session=sess)
        sess.run(train_step, feed_dict={})
    print fval.eval(session=sess, feed_dict={})
    print xmin.eval(session=sess)
    